import "bulma/css/bulma.css"
import "phoenix_html"
import Table from './Table'
import ReactDOM from 'react-dom'
import React from 'react'

const ROOT_NODE = 'reactRoot'

ReactDOM.render(<Table />, document.getElementById(ROOT_NODE))
