import React from 'react'

const usePlayersFilters = () => {
  const [search, setSearch] = React.useState('')
  const [sort, setSort] = React.useState(null)

  return {
    search,
    setSearch,
    sort,
    setSort,
  }
}

export default usePlayersFilters
