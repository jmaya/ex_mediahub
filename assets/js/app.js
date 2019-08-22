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

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

 import LiveSocket from 'phoenix_live_view'

let liveSocket = new LiveSocket("/live")
liveSocket.connect()


import "jquery-ui/ui/widget"
import "blueimp-load-image/js/load-image";
import "blueimp-load-image/js/load-image-exif"
import "blueimp-load-image/js/load-image-meta"
import "blueimp-file-upload/js/jquery.fileupload-image"
import "blueimp-load-image/js/load-image-scale"
import "blueimp-file-upload/js/jquery.fileupload"
import "blueimp-file-upload/js/jquery.fileupload-process"
import "blueimp-file-upload/js/jquery.fileupload-image"
import "blueimp-file-upload/js/jquery.fileupload-audio"
import "blueimp-file-upload/js/jquery.fileupload-video"
import "blueimp-file-upload/js/jquery.fileupload-validate"
import "blueimp-file-upload/js/jquery.fileupload-ui"
