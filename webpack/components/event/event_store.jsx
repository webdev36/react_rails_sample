import { observable, observe, toJS } from 'mobx'

export default class Store {
  @observable page = 1
  @observable usersPage = 1
  @observable events = []
  @observable users = []
  @observable featuredEvents = []
}
