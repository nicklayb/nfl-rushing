import React from 'react'
import { Context } from './usePlayers'
import { Table } from '../Table'
import Loading from '../Loading'

const COLUMNS = {
  name: 'Player',
  team: 'Team',
  position: 'Pos',
  attempts: 'Att',
  attempts_per_game: 'Att/G',
  yards: 'Yds',
  average: 'Avg',
  yards_per_game: 'Yds/G',
  rushing_touchdowns: 'TD',
  longest_rush: 'Lng',
  first_downs: '1st',
  first_downs_percent: '1st%',
  rushing_plus_20: '20+',
  rushing_plus_40: '40+',
  fumbles: 'FUM',
}

const SORTABLE = ['yards', 'rushing_touchdowns', 'longest_rush']

const TABLE_COLUMNS = Object.entries(COLUMNS).map(([column, title]) => ({
  key: column,
  title,
  render: row => row[column],
  sortable: SORTABLE.includes(column)
}))

const PlayersTable = () => {
  const { state, filters } = React.useContext(Context)

  return (
    <div className='column'>
      {state.isLoading && <Loading />}
      <Table
        rows={state.players}
        columns={TABLE_COLUMNS}
        sort={filters.sort}
        onSort={newSort => filters.setSort(newSort)}
      />
    </div>
  )
}

export default PlayersTable
