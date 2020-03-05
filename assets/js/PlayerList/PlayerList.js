import React from 'react'
import PlayersTable from './PlayersTable'
import PlayersFilters from './PlayersFilters'

const PlayerList = () => (
  <div className='container'>
    <div className='section'>
      <div className='columns'>
       <PlayersFilters />
      </div>
      <div className='columns'>
        <PlayersTable />
      </div>
    </div>
  </div>
)

export default PlayerList
