
using Actors.Player;
using UnityEngine;

namespace UI.TouchUI {
    public class ShootTouchButton : MonoBehaviour {
        private Rect rectPosition;

        private void Awake(){
            rectPosition = new Rect(transform.position, transform.localScale); 
        }

        private void OnGUI(){
            Clicked();
        }

        private void Clicked(){
            if (GUI.RepeatButton(rectPosition, name) == false) return;
            PlayerInput.shoot();
        }
    }
}
