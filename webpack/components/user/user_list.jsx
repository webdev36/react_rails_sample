import React, { Component, PropTypes } from 'react'
import UserItem from 'components/user/user_item'
import { observer } from 'mobx-react';

@observer
export default class UserList extends Component {
  constructor(props) {
    super(props)
  }

  render () {
    let users = this.context.store.users.map((user, i) => {
      return (<UserItem user={user} key={`user-${user.id}`} />)
    })

    return (
      <div>
        <h3 className="">Found Users</h3>
        <div className="event-list-wrap" >
          { users }
        </div>
      </div>
      )
  }
}

UserList.contextTypes = {
  store: PropTypes.object
}
