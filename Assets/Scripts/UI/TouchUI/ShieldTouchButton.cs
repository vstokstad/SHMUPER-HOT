using System;
using Actors.Player;
using UnityEngine;
using UnityEngine.UI;

namespace UI.TouchUI {
    [RequireComponent(typeof(Button))]
    public class ShieldTouchButton : MonoBehaviour {
        public Button shieldButton;
        

        private void Start(){
            shieldButton = this.shieldButton.GetComponent<Button>();
            shieldButton.onClick.AddListener(Clicked);
        }

        private static void Clicked(){
            PlayerInput.shield();
        }
        private void OnDisable(){
            shieldButton.onClick.RemoveAllListeners();
        }
    }
}