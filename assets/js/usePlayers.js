import React from 'react'
import queryString from 'query-string'

const URL = "/api/players"

const fetchPlayers = (params) => {
  const url = queryString.stringifyUrl({
    url: URL,
    query: params
  })
  return fetch(url).then(response => response.json())
}

const DEFAULT = {
  search: '',
  sort: null,
}

export const usePlayers = (params = DEFAULT) => {
  const [players, setPlayers] = React.useState([])
  const [isLoading, setIsLoading] = React.useState(false)

  const update = () => {
    setIsLoading(true)

    fetchPlayers(params)
      .then(({ data }) => { setPlayers(data) })
      .finally(() => { setIsLoading(false) })
  }

  React.useEffect(() => {
    update()
  }, [params.search, params.sort])

  return { players, isLoading, setIsLoading }
}
