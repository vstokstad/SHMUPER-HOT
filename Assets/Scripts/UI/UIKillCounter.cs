using Actors.Player;
using TMPro;
using UnityEngine;

namespace UI {
    public class UIKillCounter : MonoBehaviour {
       [SerializeField] private TextMeshProUGUI _killCounter;
        private string _killCountString;
       [SerializeField] private PlayerController _playerController;
        private PlayerData _playerData;

        private void Awake(){
    
            _playerData = _playerController.playerData;
            _killCountString = "Kills: " + _playerController.killCounter + "\nHighscore: " + _playerData.highScore;
            _killCounter.text = _killCountString;
        }

        private void OnGUI(){
            _killCountString = "Kills: " + _playerController.killCounter + "\nHighscore: " + _playerData.highScore;
            _killCounter.text = _killCountString;
        }
    }
}