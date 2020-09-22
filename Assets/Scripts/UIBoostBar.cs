using UnityEngine;
using UnityEngine.UI;

public class UIBoostBar : MonoBehaviour {
    private Slider _slider;
    private float _value;

    private void Awake(){
        _slider = GetComponent<Slider>();
        _slider.value = PlayerData.boostCharge;
    }

    private void OnGUI(){
        _slider.value *= Time.deltaTime;
        _slider.value = PlayerData.boostCharge;
    }
}