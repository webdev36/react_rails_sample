import React, { Component, PropTypes } from 'react'
import axios from 'axios'
import { observer } from 'mobx-react'

import EventList from './event_list.jsx'
import UserList from 'components/user/user_list.jsx'
import PastEventsList from './past_events_list.jsx';

import Store from './event_store'

var store;

@observer
export default class EventSearch extends Component {
  constructor (props) {
    super(props)
    store = new Store()
  }

  getChildContext() {
    return {
      store }
  }

  componentDidMount = () => {
    this.search();
  }

  loadMore = () => {
    store.page = store.page + 1
    store.usersPage = store.usersPage + 1
    this.search(true)
  }

  search = (append = false) => {
    let self = this

    // Search for events.
    axios.get('/api/v1/events.json', {
      params: { search_term: self.refs.searchInput.value, page: store.page }
    })
    .then(function (response) {
      if (append) {
        store.events = store.events.concat(response.data.data)
      } else {
        store.events = response.data.data
        store.page = 1
      }
    })
    .catch(function (error) {
      console.log(error);
    })

    // Search for users.
    axios.get('/api/v1/users.json', {
      params: { search_term: self.refs.searchInput.value, page: store.usersPage }
    })
    .then(function (response) {
      if (append) {
        store.users = store.users.concat(response.data.data)
      } else {
        store.users = response.data.data
        store.usersPage = 1
      }
    })
    .catch(function (error) {
      console.log(error);
    })
  }

  render () {
    return (
      <div>
        <div className="row">
          <div className="">
            <div className="search-box">
              <div id="custom-search-input">
                <div className="input-group col-md-12">
                  <span className="input-group-btn">
                      <i className="glyphicon glyphicon-search"></i>
                  </span>
                  <input ref='searchInput' onKeyUp={() => this.search(false)} type='text' name='search-events' placeholder='Search for online events & creators' className="form-control input-lg" />
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="row">
          <div className="">
            <div className="white-background">
              <ul className="nav nav-tabs" role="tablist">

                <li role="presentation" className="active"><a href="#events" aria-controls="events" role="tab" data-toggle="tab">Events</a></li>


                <li role="presentation"><a href="#users" aria-controls="users" role="tab" data-toggle="tab">Users</a></li>

              </ul>

              <div className="tab-content">
                <div role="tabpanel" className="tab-pane active" id="events">
                  <EventList />
                </div>

                <div role="tabpanel" className="tab-pane" id="users">
                  <UserList />
                </div>

              </div>

              <button className="btn" onClick={this.loadMore}>Load More</button>
            </div>
          </div>
        </div>
      </div>
    )
  }
}

EventSearch.childContextTypes = {
  store: PropTypes.object
}
