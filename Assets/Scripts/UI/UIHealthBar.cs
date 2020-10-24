using System;
using Actors.Player;
using UnityEngine;
using UnityEngine.UI;

namespace UI {
    public class UIHealthBar : MonoBehaviour {
        public Slider slider;
        public Slider.SliderEvent SliderEvent { get; } = new Slider.SliderEvent();

private void Awake(){
            slider = GetComponent<Slider>();

            slider.value = PlayerData.health;
        }
        
        private void OnGUI(){
            slider.value = PlayerData.health;
          
        }
    }
}