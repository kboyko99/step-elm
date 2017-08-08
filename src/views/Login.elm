import Html exposing (Html, div, text, form, button, input, node, p)
import Html.Attributes exposing (type_, action, value, disabled, style, placeholder, method, name, required, class, attribute, rel, href)
import Html.Events exposing (onSubmit, onInput, onClick)
import Style exposing (..)

import Http
import Json.Decode as Json
import Json.Encode

stylesheets =
    [ node "link" [rel "stylesheet", href "https://fonts.googleapis.com/css?family=Open+Sans:300,400"][]
    , node "link" [rel "stylesheet", href "../../dist/css/style.css"][]
    ]

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

-- MODEL

type alias Model =
  { name : String
  , password : String
  , hidden : String
  }

model : Model
model =
  Model "" "" "true"

-- UPDATE

type Msg
    = Name String
    | Password String
    | Hidden String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    Hidden hidden ->
      { model | hidden = hidden }


-- VIEW


view : Model -> Html Msg
view model =
 div []
 [ div [] stylesheets
 , div [class "wrapper"]
    [ button [onClick (Hidden "false")][text "Log In"]
    , viewValidation model
    ]
 ]

viewValidation : Model -> Html Msg
viewValidation model =
  let
    hiddenClass =
      if model.hidden == "true" then
        "hidden"
      else
        ""
  in
    div [class hiddenClass]
        [ div [class "dialogOverlay"][]
        , div [class "dialog"]
              [ form [action "http://localhost:3073/login", method "POST"]
                  [ input [ type_ "text", placeholder "login", onInput Name, name "login", required True] []
                  , input [ type_ "password", placeholder "**********", onInput Password, name "password", required True] []
                  , input [ type_ "submit", value "submit"] []
                  ]
              ]
        ]
--    div [ style [("color", color)] ] [ text message ]
