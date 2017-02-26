import React, { Component, PropTypes } from 'react'
import FormError                       from './../shared/form_error'

export default class EventEdit extends Component {
  constructor(props) {
    super(props)
    this.state = {
      errors: {}
    }
  }

  editEvent = (e) => {
    this.setState({ errors: {} })
    let params = {
      title: this.refs.title.value,
      caption: this.refs.caption.value,
      link: this.refs.link.value,
      scheduled_at: this.refs.scheduledAt.value
    }

    let self = this
    $.ajax({
      url: "/api/v1/events/" + self.props.id,
      data: JSON.stringify({ event: params}),
      type: 'PUT',
      contentType: 'application/json',
      dataType: 'json'
    })
    .done((response) => {
      window.location = `/events/${response.id}-${response.slug}`
    })
    .fail((data) => {
      this.setState({ errors: data.responseJSON })
    })

    e.preventDefault()
  }

  componentDidMount = () => {
    new Flatpickr(this.refs.scheduledAt, {
      utc: true,
      minDate: new Date(),
      enableTime: true,
      altInput: true,
      altFormat: "F j, Y h:i K",
      utc: true
    });
  }

  render () {
    return (
      <div className="form-wrap ">
          <div className="col-md-8 col-md-offset-2 col-xs-12">
            <form onSubmit={this.editEvent}>
              <div className="form-group" id="form-field">
                <label htmlFor="title">Title</label>
                <input ref="title" defaultValue={this.props.title} type="text" required className="form-control" id="title" placeholder="What's your event called?" />
                { this.state.errors['title'] && <FormError text={this.state.errors['title'][0]} /> }
                </div>

                <div className="form-group" id="form-field">
                  <label htmlFor="caption">Caption</label>
                  <input ref="caption" defaultValue={this.props.caption} type="text" required className="form-control" id="caption" placeholder="Please tell us a little about it" />
                  { this.state.errors['caption'] && <FormError text={this.state.errors['caption'][0]} /> }
                  </div>

                  <div className="form-group" id="form-field">
                    <label htmlFor="link">Link</label>
                    <input ref="link" defaultValue={this.props.link} pattern="https?://.+" required type="url" className="form-control" id="link" placeholder="The url for your event" />
                    { this.state.errors['link'] && <FormError text={this.state.errors['link'][0]} /> }
                    </div>

                    <div className="form-group" id="form-field">
                      <label htmlFor="scheduledAt">Scheduled At</label>
                      <input ref="scheduledAt" defaultValue={this.props.scheduled_at} required type='text' placeholder="Click to toggle scheduler" className="form-control" />
                      { this.state.errors['scheduled_at'] && <FormError text={this.state.errors['scheduled_at'][0]} /> }
                      </div>
                  <button type="submit" className="btn submit-event-btn btn-block">Submit</button>

                    </form>
                  </div>
              </div>
    )
  }
}
