using TMPro;
using UnityEngine;

public class UIKillCounter : MonoBehaviour {
    private TextMeshProUGUI _killCounter;
    private string _killCountString;
    private PlayerController _playerController;
    private PlayerData _playerData;

    private void Awake(){
        _killCounter = GetComponent<TextMeshProUGUI>();
        _killCountString = _killCounter.text;
        _playerController = FindObjectOfType<PlayerController>();
        _playerData = _playerController.playerData;
    }

    private void OnGUI(){
        _killCountString = "Kills: " + _playerController.killCounter + "\nHighscore: " + _playerData.highScore;
        _killCounter.text = _killCountString;
    }
}