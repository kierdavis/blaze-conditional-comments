{-# LANGUAGE OverloadedStrings #-}

-- | Conditional comments for @blaze-html@. The combinators can be used like
--   any other Blaze combinators, for example:
--
--   > ifIELessThan 8 $ do
--   >   H.link ! A.rel "stylesheet"
--   >          ! A.type_ "text/css"
--   >          ! A.href "/path/to/ie-only.css"
module Text.Blaze.Html.ConditionalComments ( ifIE
                                           , ifNotIE
                                           , ifIEExact
                                           , ifIELessThan
                                           , ifIEGreaterThan
                                           , ifIELessThanOrEqualTo
                                           , ifIEGreaterThanOrEqualTo
                                           ) where
    
    import GHC.Exts (fromString)
    import Text.Blaze.Html (Html)
    import Text.Blaze.Internal (MarkupM(Parent))
    
    -- | @\<!--[if IE]>@ ... @\<![endif]-->@
    --   
    --   Content is only evaluated in Internet Explorer.
    ifIE :: Html -> Html
    ifIE = Parent "ifIE" "<!--[if IE]" "<![endif]-->"
    
    -- | @\<!--[if !IE]> -->@ ... @\<!-- \<![endif]-->@
    --   
    --   Content is not evaluated in Internet Explorer. It has a different
    --   syntax to the other combinators, so that it will be evaluated by
    --   browsers not implementing conditional comments.
    ifNotIE :: Html -> Html
    ifNotIE = Parent "ifNotIE" "<!--[if !IE]> --" "<!-- <![endif]-->"
    
    -- | @\<!--[if IE *]>@ ... @\<![endif]-->@
    --
    --   Content is only evaluated in a specific version of Internet Explorer.
    ifIEExact :: Int -> Html -> Html
    ifIEExact ver = Parent "ifIEExact" tag "<![endif]-->"
      where
        tag = fromString $ "<!--[if IE " ++ show ver ++ "]"
    
    -- | @\<!--[if lt IE *]>@ ... @\<![endif]-->@
    --
    --   Content is only evaluated in versions of Internet Explorer less than
    --   the given argument.
    ifIELessThan :: Int -> Html -> Html
    ifIELessThan ver = Parent "ifIELessThen" tag "<![endif]-->"
      where
        tag = fromString $ "<!--[if lt IE " ++ show ver ++ "]"
    
    -- | @\<!--[if gt IE *]>@ ... @\<![endif]-->@
    --   
    --   Content is only evaluated in versions of Internet Explorer greater than
    --   the given argument.
    ifIEGreaterThan :: Int -> Html -> Html
    ifIEGreaterThan ver = Parent "ifIEGreaterThen" tag "<![endif]-->"
      where
        tag = fromString $ "<!--[if gt IE " ++ show ver ++ "]"
    
    -- | @\<!--[if lte IE *]>@ ... @\<![endif]-->@
    --   
    --   Content is only evaluated in versions of Internet Explorer less than or
    --   equal to the given argument.
    ifIELessThanOrEqualTo :: Int -> Html -> Html
    ifIELessThanOrEqualTo ver =
        Parent "ifIELessThanOrEqualTo" tag "<![endif]-->"
      where
        tag = fromString $ "<!--[if lte IEe " ++ show ver ++ "]"
    
    -- | @\<!--[if gte IE *]>@ ... @\<![endif]-->@
    --
    --   Content is only evaluated in versions of Internet Explorer greater than
    --   or equal to the given argument.
    ifIEGreaterThanOrEqualTo :: Int -> Html -> Html
    ifIEGreaterThanOrEqualTo ver =
        Parent "ifIEGreaterThanOrEqualTo" tag "<![endif]-->"
      where
        tag = fromString $ "<!--[if gte IEe " ++ show ver ++ "]"
