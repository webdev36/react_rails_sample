import React, { Component, PropTypes } from 'react'
import EventItem from 'components/event/event_item'
import { observer } from 'mobx-react';

@observer
export default class PastEventsList extends Component{
  constructor(props) {
    super(props)
  }

  render(){
    let past_events = this.context.store.events.map((event, i) => {
        return (<EventItem event={event} key={`event-${event.id}`} />)
    })
    console.log("hello")

    return(
      <div className="event-index-flex">

        <div className="coming-events-flex"> 
          <h3 className="coming-soon">Past Events</h3>
          <div className="event-list-wrap" > 
            {past_events}
          </div>
        </div> 

      </div>
      )
  }
}
PastEventsList.contextTypes = {
  store: PropTypes.object
}
