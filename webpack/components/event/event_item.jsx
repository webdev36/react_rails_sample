import React, { Component } from 'react';
import moment from 'moment';
import Switch from 'react-bootstrap-switch';

export default class EventItem extends Component {
  constructor (props) {
    super(props)
    this.state = { subscribed_to_event: props.event.subscribed_to_event }
  }

  momentTime = () => {
    return moment(this.props.event.scheduled_at).fromNow()
  }

  toggleSubscription = () => {
    let self = this
    if (this.state.subscribed_to_event) {
      $.ajax({
        url: `/api/v1/subscriptions/${self.props.event.id}`,
        type: 'DELETE',
        success: function(response) {
          self.setState({ subscribed_to_event: false })
        }
      });
    } else {
      $.post("/api/v1/subscriptions", { id: this.props.event.id }, (response) => {
        this.setState({ subscribed_to_event: true })
      })
    }
  }

  render () {
    const {subscribers,title,user,id,slug,profile_pic,real_name, scheduled_at} = this.props.event; 
    console.log(scheduled_at); 
    return (
      <div className="event-item-wrap">

        <div className="subscribers">
          <h2><i className="glyphicon glyphicon-bell"></i></h2>
          <h4>{subscribers}</h4>
        </div>

        <div className="img-flex">
          <div className="event-image">
            <img className='img-responsive' height="100" width="100" src={profile_pic}  alt="https://placehold.it/100"/>
          </div>
        </div>

        <div className="event-info">
          <a href={`/events/${id}-${slug}`} className="">
            <h3 className="title">{title}</h3>
      </a>
            <p className="user"> added by {real_name} </p>
            <p className="countdown">{this.momentTime()}</p>

        </div>

      </div>
    )
  }
}
