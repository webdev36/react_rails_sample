import React, { Component } from 'react'

export default class FormError extends Component {
  constructor (props) {
    super(props)
  }

  render () {
    return (
      <span className="help-block" style={{ color: "red" }}>
        { this.props.text }
      </span>
    )
  }
}
