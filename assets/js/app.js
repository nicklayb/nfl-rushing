import "../css/app.css"
import "phoenix_html"
import PlayerList from './PlayerList'
import ReactDOM from 'react-dom'
import React from 'react'

const ROOT_NODE = 'reactRoot'

ReactDOM.render(<PlayerList />, document.getElementById(ROOT_NODE))
