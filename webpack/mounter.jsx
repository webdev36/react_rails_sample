import React from 'react'
import { render } from 'react-dom'

import EventSearch from './components/event/event_search'
import EventCreate from './components/event/event_create'
import EventEdit   from './components/event/event_edit'
import EventCountdown   from './components/event/event_countdown'

var componentMap = {
  EventSearch,
  EventCreate,
  EventEdit,
  EventCountdown
}

for (var el of document.querySelectorAll('[data-component]')) {
  let json = JSON.parse(el.getAttribute('data-react-props'))
  let found = false
  for (let key of Object.keys(componentMap)) {
    if (key === el.getAttribute('data-component')) {
      render(React.createElement(componentMap[key], json), el)
      found = true
      break
    }
  }
  if (!found)
    throw `Could not find React component ${el.getAttribute('data-component')}.`
}
