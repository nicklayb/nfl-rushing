import React from 'react'
import { usePlayers } from './usePlayers'
import { Table } from './Table'
import { useDebounce } from 'use-debounce'
import Loading from './Loading'

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

const DEBOUNCE_TIME = 500

const TABLE_COLUMNS = Object.entries(COLUMNS).map(([column, title]) => ({
  key: column,
  title,
  render: row => row[column],
  sortable: SORTABLE.includes(column)
}))

const PlayerList = () => {
  const [search, setSearch] = React.useState('')
  const [sort, setSort] = React.useState(null)
  const [debouncedSearch] = useDebounce(search, DEBOUNCE_TIME)
  const { players, isLoading, setIsLoading } = usePlayers({
    search: debouncedSearch,
    sort
  })

  React.useEffect(() => {
    if (!isLoading) {
      setIsLoading(true)
    }
  }, [search])

  return (
    <div className='container'>
      <div className='columns'>
        <div className='column'>
          <input className='input' placeholder='Search by name' value={search} onChange={({ target }) => setSearch(target.value)} />
        </div>
      </div>
      <div className='columns'>
        <div className='column'>
          {isLoading && <Loading />}
          <Table
            rows={players}
            columns={TABLE_COLUMNS}
            sort={sort}
            onSort={newSort => setSort(newSort)}
          />
        </div>
      </div>
    </div>
  )
}

export default PlayerList
