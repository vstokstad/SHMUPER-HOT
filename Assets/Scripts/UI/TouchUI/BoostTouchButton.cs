using Actors.Player;
using UnityEngine;
using UnityEngine.UIElements;
using Button = UnityEngine.UI.Button;


namespace UI.TouchUI {
    [RequireComponent(typeof(Button))]
    public class BoostTouchButton : MonoBehaviour {
        public Button boostButton;

        private void Start(){
            boostButton = this.boostButton.GetComponent<Button>();
            boostButton.onClick.AddListener(Clicked); ;
        }

        private static void Clicked(){
            PlayerInput.boost();
        }

        private void OnDisable(){
            boostButton.onClick.RemoveAllListeners();
        }
    }
}