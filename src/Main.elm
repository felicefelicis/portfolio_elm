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



import Html exposing ( .. )

import Html.Attributes exposing ( .. )

import Random.Pcg as Random



-- MODEL
{-| Le modèle de notre application.
Contient tout les états modifiables de notre programme.
-}
type alias Model =
    { backgroundImage : Int
    }


{-| Valeur initiale du modèle.
On initialise `backgroundImage` à 1 uniquement afin de satisfaire le type `Model`
puisque sa valeur sera automatiquement remplacée par une valeur aléatoire.
-}
model : Model
model =
    { backgroundImage = 1
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
type Msg = SetBgImage Int



-- UPDATE

{-| Transforme le modèle en fonction du message reçu. 
-}
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetBgImage n -> ({ backgroundImage = n }, Cmd.none)



--VIEW

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
