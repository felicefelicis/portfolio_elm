module Main exposing ( .. )

import Html exposing ( .. )

import Html.Attributes exposing ( .. )



-- MODEL

type alias Model = List Int

model : Model
model = []

init : (Model, Cmd Msg)
init = (model, Cmd.none)


-- MESSAGES

type alias Msg = Never



-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    (model, Cmd.none)



--VIEW

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
    , div [ id "entete" ]
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
        []
    , div [ id "joindre" ]
        []
    ] 



-- MAIN

main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }
