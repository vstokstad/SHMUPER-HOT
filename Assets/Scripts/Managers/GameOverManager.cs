using Actors.Player;
using JetBrains.Annotations;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;
using static Managers.TagsAsStrings;

namespace Managers {
    public class GameOverManager : MonoBehaviour {
        private PlayerInput _playerInput;
        private TimeManager _timeManager;
        private PlayerData _playerData;
        private PlayerController _playerController;
        private float _highScoreStateAtDeath;
  

        private void OnEnable(){
            _playerController = FindObjectOfType<PlayerController>();
            _timeManager = FindObjectOfType<TimeManager>();
            _timeManager.gamePaused = true;
            _timeManager.timeState = TimeState.Stopped;
            _highScoreStateAtDeath = _playerController.playerData.highScore;
            
        }
        private void Update(){
            if (!Input.anyKeyDown) return;
            ResetGame();
       
        }

        private void ResetGame(){
            PlayerData.health = 10f;
            _playerController.playerData.highScore = _highScoreStateAtDeath;
            _playerController.killCounter = 0f;
            PlayerData.boostCharge = 10f;
            _timeManager.gamePaused = false;
            DontDestroyOnLoad(GameObject.FindWithTag(playerTag));
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
       
      
            this.enabled = false;
        }

      
    }
}