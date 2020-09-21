using UnityEngine;
using UnityEngine.UI;

public class RechargeGUI : MonoBehaviour {
    private float value;
    private Slider slider;
    private PlayerController _playerController;

    private void Awake(){
        slider = GetComponent<Slider>();
        _playerController = GameObject.FindWithTag("Player").GetComponent<PlayerController>();
        slider.value = _playerController.playerData.boostCharge;
    }

    private void OnGUI(){
        slider.value = _playerController.playerData.boostCharge;
    }
}
