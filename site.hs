--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid ((<>))
import           Hakyll


--------------------------------------------------------------------------------
siteRoot = "https://kgadek.github.io"

main :: IO ()
main = hakyll $ do
    match "LICENSE" $ do
        route $ setExtension "txt"
        compile copyFileCompiler

    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["gpg.rst"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" commonContext
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts)
                 <> constField "title" "Archives"
                 <> commonContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx = listField "posts" postCtx (return posts)
                        <> commonContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler


    let feedCtx = postCtx
               <> bodyField "description"

        feedConfig :: FeedConfiguration
        feedConfig = FeedConfiguration
            { feedTitle       = "kgadek.github.io"
            , feedDescription = "Haskell, UNIX, dead parrots, and oxford comma"
            , feedAuthorName  = "Konrad Gądek"
            , feedAuthorEmail = "kgadek@gmail.com"
            , feedRoot        = siteRoot
            }

    create ["feed.xml"] $ do
        route idRoute
        compile $ loadAllSnapshots "posts/*" "content"
              >>= mapM (loadAndApplyTemplate "templates/feedEntry.html" feedCtx)
              >>= (take 10 <$>) . recentFirst
              >>= renderRss feedConfig feedCtx

    create ["atom.xml"] $ do
        route idRoute
        compile $ loadAllSnapshots "posts/*" "content"
              >>= mapM (loadAndApplyTemplate "templates/feedEntry.html" feedCtx)
              >>= (take 10 <$>) . recentFirst
              >>= renderAtom feedConfig feedCtx

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y"
 <> commonContext

commonContext :: Context String
commonContext =
    constField "siteRoot" siteRoot
 <> defaultContext
