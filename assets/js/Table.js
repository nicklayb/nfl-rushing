import React from 'react'

const getSortedClass = (column, sort) => {
  if (column === sort) {
    return 'sorted-asc'
  }

  if (`-${column}` === sort) {
    return 'sorted-desc'
  }

  return ''
}

const toggleSort = (current, newSort) => {
  if (current === newSort) {
    return `-${current}`
  }

  return newSort
}

const SortableHeader = ({ column, sort, onSort }) => (
  <th
    className={['sortable', getSortedClass(column.key, sort)].join(' ')}
    onClick={() => onSort(toggleSort(sort, column.key))}
  >{column.title}</th>
)

const Header = ({ column }) => (
  <th>{column.title}</th>
)

const TableHead = ({ columns, sort, onSort }) => (
  <thead>
    <tr>
      {columns.map(column => (
        column.sortable
          ? <SortableHeader key={column.key} column={column} sort={sort} onSort={onSort} />
          : <Header key={column.key} column={column} />
      ))}
    </tr>
  </thead>
)

const TableBody = ({ columns, rows }) => (
  <tbody>
    {rows.map(row => (
      <tr key={row.name}>
        {columns.map(column => <td key={column.key}>{column.render(row)}</td>)}
      </tr>
    ))}
  </tbody>
)

export const Table = ({ rows, columns, sort, onSort }) => (
  <table className='table is-fullwidth'>
    <TableHead columns={columns} sort={sort} onSort={onSort} />
    <TableBody rows={rows} columns={columns} />
  </table>
)
