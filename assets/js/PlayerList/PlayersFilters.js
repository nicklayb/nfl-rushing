import React from 'react'
import { useDebounce } from 'use-debounce'
import { Context, downloadUrl } from './usePlayers'

const DEBOUNCE_TIME = 500

const PlayersFilters = () => {
  const [search, setSearch] = React.useState('')
  const [debouncedSearch] = useDebounce(search, DEBOUNCE_TIME)
  const { state, filters } = React.useContext(Context)

  React.useEffect(() => {
    filters.setSearch(debouncedSearch)
  }, [debouncedSearch])

  const getExportUrl = () => downloadUrl(filters)

  React.useEffect(() => {
    if (!state.isLoading) {
      state.setIsLoading(true)
    }
  }, [search])

  return (
    <div className='column'>
      <div className="field has-addons">
        <div className="control is-expanded">
          <input className='input' placeholder='Search by name' value={search} onChange={({ target }) => setSearch(target.value)} />
        </div>
        <div className="control">
          <a className='button is-primary' href={getExportUrl()} target="_blank">Export</a>
        </div>
      </div>
    </div>
  )
}

export default PlayersFilters
