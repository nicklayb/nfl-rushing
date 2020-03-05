import "../css/app.css"
import "phoenix_html"
import Application from './Application'
import ReactDOM from 'react-dom'
import React from 'react'

const ROOT_NODE = 'reactRoot'

ReactDOM.render(<Application />, document.getElementById(ROOT_NODE))
