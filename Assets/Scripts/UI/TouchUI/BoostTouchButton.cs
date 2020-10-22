using Actors.Player;
using UnityEngine;

namespace UI.TouchUI {
    public class BoostTouchButton : MonoBehaviour {
        private Rect _rectPosition;

        private void Awake(){
            _rectPosition = new Rect(transform.position, transform.localScale);
        }

        private void OnGUI(){
            Clicked();
        }

        private void Clicked(){
            if (GUI.RepeatButton(_rectPosition, name) == false) return;
            PlayerInput.boost();
        }
    }
}