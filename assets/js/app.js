// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import 'bootstrap'
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//

import "phoenix_html"
import jQuery from "jquery"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import LiveSocket from 'phoenix_live_view'

let liveSocket = new LiveSocket("/live")
liveSocket.connect()


jQuery(document).ready(function ($) {

    function initDropzone() {
        window.Dropzone = require('dropzone/dist/min/dropzone.min');
        let options = {
            acceptedFiles: 'video/*',
            params: {
                course_id: window.location.pathname.split("/").reverse()[0]
            }


        }

        Dropzone.options.uploadWidget = options

    }
    $(document).on("phx:update", initDropzone)
})