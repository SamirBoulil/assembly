import Immutable   from 'immutable';
import AltInstance from '../lib/AltInstance';

class DeputyListActions {
	updateDeputyList() { this.dispatch(); }
}

export default AltInstance.createActions(DeputyListActions);
