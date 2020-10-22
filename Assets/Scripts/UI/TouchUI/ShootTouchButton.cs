
using Actors.Player;
using UnityEngine;

namespace UI.TouchUI {
    public class ShootTouchButton : MonoBehaviour {
        private Rect _rectPosition;

        private void Awake(){
            var transform1 = transform;
            _rectPosition = new Rect(transform1.position, transform1.localScale);
        }

        private void OnGUI(){
            Clicked();
        }

        private void Clicked(){
            if (GUI.RepeatButton(_rectPosition, name) == false) return;
            PlayerInput.shoot();
        }
    }
}
