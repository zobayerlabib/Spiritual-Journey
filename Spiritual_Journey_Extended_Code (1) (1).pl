% Define states (main states)
state(initial).
state(tazkiyah).
state(arifin).
state(muqarrabin).
state(al_mutmainnah). % A new state added

% Define sub-states within each state
substate(tazkiyah, remove_arrogance).
substate(tazkiyah, increase_dhikr).
substate(tazkiyah, repentance).

substate(arifin, study_quran).
substate(arifin, reflect_creation).
substate(arifin, seek_knowledge).

substate(muqarrabin, pray_tahajjud).
substate(muqarrabin, sincerity_in_worship).
substate(muqarrabin, complete_detachment).

% New sub-states for al_mutmainnah
substate(al_mutmainnah, gratitude).
substate(al_mutmainnah, contentment).
substate(al_mutmainnah, remembrance).

% Define transitions between states
transition(initial, purify_heart, tazkiyah).
transition(tazkiyah, gain_maarifah, arifin).
transition(arifin, achieve_ihsan, muqarrabin).

% New transition for al_mutmainnah
transition(muqarrabin, reach_peace, al_mutmainnah).

% Define conditions for state transitions
condition(purify_heart, [remove_arrogance, increase_dhikr, repentance]).
condition(gain_maarifah, [study_quran, reflect_creation, seek_knowledge]).
condition(achieve_ihsan, [pray_tahajjud, sincerity_in_worship, complete_detachment]).
condition(reach_peace, [gratitude, contentment, remembrance]).

% Define transitions between sub-states
transition_substate(tazkiyah, remove_arrogance, increase_dhikr).
transition_substate(tazkiyah, increase_dhikr, repentance).

transition_substate(arifin, study_quran, reflect_creation).
transition_substate(arifin, reflect_creation, seek_knowledge).

transition_substate(muqarrabin, pray_tahajjud, sincerity_in_worship).
transition_substate(muqarrabin, sincerity_in_worship, complete_detachment).

% New transitions between sub-states for al_mutmainnah
transition_substate(al_mutmainnah, gratitude, contentment).
transition_substate(al_mutmainnah, contentment, remembrance).

% Rule to find the next state
next_state(CurrentState, Action, NextState) :-
    transition(CurrentState, Action, NextState),
    condition(Action, Conditions),
    check_conditions(Conditions).

% Rule to find the next substate within a state
next_substate(State, CurrentSubstate, Action, NextSubstate) :-
    substate(State, CurrentSubstate),
    transition_substate(State, CurrentSubstate, NextSubstate),
    satisfied(Action).

% Check if all conditions are satisfied
check_conditions([]).
check_conditions([H|T]) :-
    satisfied(H),
    check_conditions(T).

% Define satisfied conditions (these can be made dynamic)
satisfied(remove_arrogance).
satisfied(increase_dhikr).
satisfied(repentance).
satisfied(study_quran).
satisfied(reflect_creation).
satisfied(seek_knowledge).
satisfied(pray_tahajjud).
satisfied(sincerity_in_worship).
satisfied(complete_detachment).

% New satisfied conditions for al_mutmainnah
satisfied(gratitude).
satisfied(contentment).
satisfied(remembrance).

% Dynamically link conditions to user actions
user_action(remove_arrogance).
user_action(increase_dhikr).
user_action(repentance).
user_action(study_quran).
user_action(reflect_creation).
user_action(seek_knowledge).
user_action(pray_tahajjud).
user_action(sincerity_in_worship).
user_action(complete_detachment).
user_action(gratitude).
user_action(contentment).
user_action(remembrance).


% Example queries:
% 1. To test next state:
% ?- next_state(muqarrabin, reach_peace, NextState).
% Expected Output: NextState = al_mutmainnah.

% 2. To test next sub-state:
% ?- next_substate(al_mutmainnah, gratitude, _, NextSubstate).
% Expected Output: NextSubstate = contentment.

% 3. To test condition satisfaction:
% ?- condition(reach_peace, Conditions), check_conditions(Conditions).
% Expected Output: Conditions = [gratitude, contentment, remembrance], true.
