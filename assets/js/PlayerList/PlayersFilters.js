import React from 'react'
import { useDebounce } from 'use-debounce'
import { Context, downloadUrl } from './usePlayers'

const DEBOUNCE_TIME = 500

const perPageLabel = perPage =>
  perPage > 0
    ? `${perPage} per page`
    : `All records`

const PerPageSelect = ({ value, onChange }) => (
  <div className='select'>
    <select value={value} onChange={({ target }) => onChange(parseInt(target.value, 10))}>
      {[0, 10, 25, 50, 100].map(amount => (
        <option key={amount} value={amount}>{perPageLabel(amount)}</option>
      ))}
    </select>
  </div>
)

const PlayersFilters = () => {
  const [search, setSearch] = React.useState('')
  const [debouncedSearch] = useDebounce(search, DEBOUNCE_TIME)
  const { state, filters } = React.useContext(Context)

  React.useEffect(() => {
    filters.setSearch(debouncedSearch)
  }, [debouncedSearch])

  const getExportUrl = () => downloadUrl(filters.requestParams)

  React.useEffect(() => {
    if (!state.isLoading) {
      state.setIsLoading(true)
    }
  }, [search])

  return (
    <div className='column'>
      <div className='field has-addons'>
        <div className='control is-expanded'>
          <input className='input' placeholder='Search by name' value={search} onChange={({ target }) => setSearch(target.value)} />
        </div>
        <div className='control'>
          <PerPageSelect value={filters.perPage} onChange={filters.setPerPage} />
        </div>
        <div className='control'>
          <a className='button is-primary' href={getExportUrl()} target='_blank'>Export</a>
        </div>
        <div className='control'>
          <button
            className='button is-info'
            onClick={() => filters.prevPage()}
            disabled={!filters.hasPrevPage()}
          >
            {'<'}
          </button>
        </div>
        <div className='control'>
          <button className='button is-info' disabled={true}> {filters.currentPage + 1} </button>
        </div>
        <div className='control'>
          <button
            className='button is-info'
            onClick={() => filters.nextPage(state.players.length)}
            disabled={!filters.hasNextPage(state.players.length)}
          >
            {'>'}
          </button>
        </div>
      </div>
    </div>
  )
}

export default PlayersFilters
