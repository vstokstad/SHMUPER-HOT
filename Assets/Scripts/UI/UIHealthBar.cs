using Actors.Player;
using UnityEngine;
using UnityEngine.UI;

namespace UI {
    public class UIHealthBar : MonoBehaviour {
        public static Slider slider;


        private void Start(){
            slider = GetComponent<Slider>();

            slider.value = PlayerData.health;
        }

        private void OnGUI(){
            slider.value = PlayerData.health;
        }
    }
}