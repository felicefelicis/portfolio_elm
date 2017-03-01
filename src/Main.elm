module Main exposing ( Model, model, init, Msg, update, view, main )

{-| Mon Portfolio.

Suit le modèle établit par 
  [`The elm architecture`](https://evancz.gitbooks.io/an-introduction-to-elm/content/architecture/)

# App model
@docs Model, model, init

# App message
@docs Msg

# App update
@docs update

# App view
@docs view

# Lancement de l'application
@docs main

-}

import Array exposing ( Array )

import Html exposing ( .. )

import Html.Attributes exposing ( .. )

import Html.Events exposing ( .. )

import Random.Pcg as Random



-- MODEL
type alias Url = String

type alias PortfolioItem =
    { thumbnail : Url
    , zoom : Maybe Url
    , link : Maybe Url
    , descriptionProjet : String
    , over : Bool
    }

{-| Le modèle de notre application.
Contient tout les états modifiables de notre programme.
-}
type alias Model =
    { backgroundImage : Int
    , portfolioItems : Array PortfolioItem
    }


{-| Valeur initiale du modèle.
On initialise `backgroundImage` à 1 uniquement afin de satisfaire le type `Model`
puisque sa valeur sera automatiquement remplacée par une valeur aléatoire.
-}
model : Model
model =
    { backgroundImage = 1
    , portfolioItems = Array.fromList
        [ PortfolioItem "images/portfolio/final_pad.gif" Nothing Nothing "Paddy Mimbulus Mimbletonia" False
        , PortfolioItem "images/portfolio/Lockhart_hogwarts_v1.gif" Nothing Nothing "" False 
        , PortfolioItem "images/portfolio/PA_elixir1.jpg" Nothing Nothing "" False
        , PortfolioItem "images/portfolio/equipe_elixir1.jpg" Nothing Nothing "" False
        , PortfolioItem "images/portfolio/zoomcours_elixir1.jpg" Nothing Nothing "" False
        , PortfolioItem "images/portfolio/theEndBegins1.gif" Nothing Nothing "" False
        , PortfolioItem "images/portfolio/abistiel9.png" Nothing Nothing "" False
        , PortfolioItem "images/portfolio/NEW_BANN_MM_ENCOURS5.gif" Nothing Nothing "" False
        ] 
    }


backgroundGenerator : Random.Generator Int
backgroundGenerator = Random.int 1 3


{-| Initialise la programme avec le modèle initial et lance le message SetBgImage
avec une valeur aléatoire.
-}
init : (Model, Cmd Msg)
init = (model, Random.generate SetBgImage backgroundGenerator)



-- MESSAGES

{-| Les messages de gérés par notre application.

      * `SetBgImage n`: Change la valeur de `backgroundImage`
-}
type Msg
    = SetBgImage Int
    | OverItem Int
    | OutItem Int



-- UPDATE

updatePortfolioItemOver : Int -> Bool -> Array PortfolioItem -> Array PortfolioItem
updatePortfolioItemOver index over portfolioItems = 
    let
        mItem = Array.get index model.portfolioItems
    in
    case mItem of
        Just item -> Array.set index { item | over = over } model.portfolioItems
        Nothing -> model.portfolioItems

{-| Transforme le modèle en fonction du message reçu. 
-}
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetBgImage n -> ({ model | backgroundImage = n }, Cmd.none)
        OverItem index -> ({ model | portfolioItems = updatePortfolioItemOver index True model.portfolioItems }, Cmd.none)
        OutItem index  -> ({ model | portfolioItems = updatePortfolioItemOver index False model.portfolioItems }, Cmd.none)


--VIEW
viewPortfolioItem : Int -> PortfolioItem -> Html Msg
viewPortfolioItem index item =
    div [ onMouseEnter (OverItem index)
        , onMouseLeave (OutItem index)
        ]
        [ div [ class "overItemPortfolio", hidden (not item.over) ]
            [ a [ class "www", href (Maybe.withDefault "#" item.link) ]
                [ text "WWW" ]
            , a [ class "zoom", href (Maybe.withDefault "#" item.zoom) ]
                [ text "ZOOM" ]
            , p [ class "descriptionProjet" ]
                [ text item.descriptionProjet ]
            ]
        , img [ src item.thumbnail ]
            []
        ] 

{-| Affichage du modèle
-}
view : Model -> Html Msg
view model =
    body []
    [ nav [ id "navigationPrincipale" ]
        [ ul []
            [ li []
                [ a [ href "#" ]
                    [ text "PORTFOLIO" ]
                ]
            , li []
                [ a [ href "#" ]
                    [ text "COMPÉTENCES" ]
                ]
            , li []
                [ a [ href "#" ]
                    [ text "À PROPOS" ]
                ]
            ]
        ]
    , div [ id "entete", style [ ("backgroundImage" , "url(images/bg" ++ (toString model.backgroundImage) ++ ".jpeg)") ] ]
        []
    , div [ class "nom" ]
        [ h1 []
            [ text "KATHLEEN" ]
        , h1 []
            [ text "BLACKBURN" ]
        ]
    , div [ id "portfolio" ]
        [ h3 [ class "quote" ]
            [ text "Parce qu'il faut parfois savoir être showoff" ]
        , h2 [ class "sectionTitre" ]
            [ text "Portfolio" ]
        , div [ id "conteneurProjet" ]
            (Array.toList (Array.indexedMap viewPortfolioItem model.portfolioItems))
        ]
    , div [ id "competence" ]
        [ h3 [ class "quote" ]
            [ text "J'ai des skills aussi" ]
        , h2 [ class "sectionTitre" ]
            [ text "Compétences" ]
        ]
    , div [ id "joindre" ]
        [ h3 [ class "quote" ]
            [ text "Ça serait pertinent de pouvoir me rejoindre n'est-ce pas?" ]
        , h2 [ class "sectionTitre" ]
            [ text "Me joindre" ]
        ]
    ] 



-- MAIN

{-| Lance l'application -}
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }
