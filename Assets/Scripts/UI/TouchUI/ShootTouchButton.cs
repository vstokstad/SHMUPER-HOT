using Actors.Player;
using UnityEngine;
using UnityEngine.UI;

namespace UI.TouchUI {
    [RequireComponent(typeof(Button))]
    public class ShootTouchButton : MonoBehaviour {
        public Button shootButton;

        private void Start(){
            shootButton = shootButton.GetComponent<Button>();
            shootButton.onClick.AddListener(Clicked);
        }

        private static void Clicked(){
            PlayerInput.shoot();
        }
        private void OnDisable(){
            shootButton.onClick.RemoveAllListeners();
        }
    }
}
