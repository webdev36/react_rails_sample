import React, { Component, PropTypes } from 'react'
import FormError                       from './../shared/form_error'

export default class EventCreate extends Component {
  constructor(props) {
    super(props)
    this.state = {
      errors: {}
    }
  }

  createEvent = (e) => {
    this.setState({ errors: {} })

    let scheduledLocal = new Date(this.refs.scheduledAt.value)
    let utcYear = scheduledLocal.getUTCFullYear()
    let utcMonth = scheduledLocal.getUTCMonth()
    let utcDate = scheduledLocal.getUTCDate()
    let utcHour = scheduledLocal.getUTCHours()
    let utcMin = scheduledLocal.getUTCMinutes()
    let utcSec = scheduledLocal.getUTCSeconds()
    let scheduledLocalUtc = new Date(utcYear, utcMonth, utcDate, utcHour, utcMin, utcSec)

    let params = {
      title: this.refs.title.value,
      caption: this.refs.caption.value,
      link: this.refs.link.value,
      scheduled_at: scheduledLocalUtc.toISOString()
    }

    let self = this
    $.post("/api/v1/events", { event: params }, (response) => {
      window.location = `/events/${response.id}-${response.slug}`
    })
    .fail((data) => {
      this.setState({ errors: data.responseJSON })
    })

    e.preventDefault()
  }

  componentDidMount = () => {
    new Flatpickr(this.refs.scheduledAt, {
      utc: false,
      minDate: new Date(),
      enableTime: true,
      altInput: true,
      altFormat: "F j, Y h:i K",
      onChange: function(dateObject) { console.log(dateObject) }
    });
  }

  render () {
    return (
      <div className="form-wrap">
        <div className="col-md-8 col-md-offset-2 col-xs-12">
          <form id="create-event-form" onSubmit={this.createEvent}>
            <div className="form-group " id="form-field">
              <label htmlFor="title">Title</label>
              <input ref="title" type="text" required className="form-control" id="title" placeholder="What's your event called?" />
              { this.state.errors['title'] && <FormError text={this.state.errors['title'][0]} /> }
              </div>
               <div className="form-group" id="form-field">
                <label htmlFor="caption">Caption</label>
                <input ref="caption" type="text" required className="form-control" id="caption" placeholder="Please tell us a little about it" />
                { this.state.errors['caption'] && <FormError text={this.state.errors['caption'][0]} /> }
              </div>
              <div className="form-group " id="form-field">
                <label htmlFor="link">Link URL</label>
                <input ref="link" pattern="https?://.+" required type="url" className="form-control" id="link" placeholder="Please add full URL ex: http://skedge.io/awesome-content" />
                { this.state.errors['link'] && <FormError text={this.state.errors['link'][0]} /> }
                </div>
                <div className="form-group" id="form-field">
                  <label htmlFor="scheduledAt">When is it?</label>
                  <input ref="scheduledAt" required type='text' className="form-control" placeholder="Click to toggle scheduler" id="scheduledAt"/>
                  { this.state.errors['scheduled_at'] && <FormError text={this.state.errors['scheduled_at'][0]} /> }
                  </div>
                  <button type="submit" className="btn submit-event-btn btn-block">Create</button>
                </form>
              </div>
            </div>
    )
  }
}
