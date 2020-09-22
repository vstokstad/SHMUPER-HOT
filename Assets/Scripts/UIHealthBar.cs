using UnityEngine;
using UnityEngine.UI;

public class UIHealthBar : MonoBehaviour {
    public static Slider slider;


    private void Awake(){
        slider = GetComponent<Slider>();

        slider.value = PlayerData.health;
    }

    private void OnGUI(){
        slider.value = PlayerData.health;
    }
}