import React, { Component } from 'react';
import moment from 'moment';
import Switch from 'react-bootstrap-switch';

export default class UserItem extends Component {
  constructor (props) {
    super(props)
    this.state = {
      is_following: props.user.is_following
    }
  }

  toggleFollowing = () => {
    let self = this
    if (this.state.is_following) {
      $.ajax({
        url: `/api/v1/followers/${self.props.user.id}`,
        type: 'DELETE',
        success: function(response) {
          self.setState({ is_following: false })
        }
      });
    } else {
      $.post("/api/v1/followers", { id: this.props.user.id }, (response) => {
        this.setState({ is_following: true })
      })
    }
  }

  render () {
    const {username,profile_pic,id,followers,real_name} = this.props.user; 
    return (
      <a href={`/users/${id}-${username}`} className="user-item-wrap">

        {/* 
        <div className="subscribers">
          <div>
            <p>{this.props.user.followers}</p>
          </div>
        </div>
          */}

        <div className="img-flex">
          <div className="event-image">
            <img className='img-responsive' height="100" width="100" src={profile_pic}  alt="HI :)"/>
          </div>
        </div>

        <div className="title-flex">
          <div className="event-info">
            <p className="title">{real_name}</p>
          </div>
        </div>


      </a>

    )
  }
}
