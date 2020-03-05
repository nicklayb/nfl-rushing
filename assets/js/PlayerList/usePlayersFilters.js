import React from 'react'

const usePlayersFilters = (defaultPerPage = 10) => {
  const [search, setSearch] = React.useState('')
  const [sort, setSort] = React.useState(null)
  const [perPage, setPerPage] = React.useState(defaultPerPage)
  const [currentPage, setCurrentPage] = React.useState(0)

  const hasNextPage = (rowCount) => perPage === rowCount
  const hasPrevPage = () => currentPage > 0
  const skip = currentPage * perPage

  return {
    search,
    setSearch: (search) => {
      setCurrentPage(0)
      setSearch(search)
    },
    sort,
    skip,
    setSort,
    perPage,
    setPerPage,
    currentPage,
    hasNextPage,
    hasPrevPage,
    nextPage: (rowCount) => {
      if (hasNextPage(rowCount)) {
        setCurrentPage(currentPage + 1)
      }
    },
    prevPage: () => {
      if (hasPrevPage()) {
        setCurrentPage(currentPage - 1)
      }
    },
    requestParams: { search, sort, take: perPage, skip },
  }
}

export default usePlayersFilters
