import React from 'react'
import { Provider } from './PlayerList/usePlayers'
import PlayerList from './PlayerList/PlayerList'

const Application = () => (
  <Provider>
    <PlayerList />
  </Provider>
)

export default Application
