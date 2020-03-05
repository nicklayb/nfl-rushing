import React from 'react'
import queryString from 'query-string'
import usePlayersFilters from './usePlayersFilters'

const URL = "/api/players"

const fetchPlayers = (params) => {
  const url = queryString.stringifyUrl({
    url: URL,
    query: params
  })
  return fetch(url).then(response => response.json())
}

export const downloadUrl = (params) => queryString.stringifyUrl({
  url: `${URL}/export`,
  query: params
})

export const usePlayers = () => {
  const [players, setPlayers] = React.useState([])
  const [isLoading, setIsLoading] = React.useState(false)

  const update = (params) => {
    setIsLoading(true)

    fetchPlayers(params)
      .then(({ data }) => { setPlayers(data) })
      .finally(() => { setIsLoading(false) })
  }

  return { players, isLoading, setIsLoading, update }
}

export const Context = React.createContext(null)

export const Provider = ({ children }) => {
  const state = usePlayers()
  const filters = usePlayersFilters()
  const { search, sort } = filters

  React.useEffect(() => {
    state.update({ search, sort })
  }, [search, sort])

  return (
    <Context.Provider value={{ state, filters }}>
      {children}
    </Context.Provider>
  )
}
