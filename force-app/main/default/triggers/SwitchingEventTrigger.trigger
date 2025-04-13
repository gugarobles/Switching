trigger SwitchingEventTrigger on Switching_Event__e (after insert) {
    for (Switching_Event__e event : Trigger.new) {
        SwitchingEventHandler.handleEvent(event);
    }
}