using UnityEngine;
using UnityEngine.SceneManagement;


public class GameOverScript : MonoBehaviour {
    private Input _input;
    private TimeManager _timeManager;
    private PlayerData _playerData;
    private PlayerController _playerController;
    private float _highScoreStateAtDeath;


    private void Update(){
        _timeManager.gamePaused = true;
        _timeManager.timeState = TimeState.Stopped;
        if (UnityEngine.Input.anyKey) {
            AsyncOperation asyncLoad = SceneManager.LoadSceneAsync(SceneManager.GetActiveScene().buildIndex);
            asyncLoad.allowSceneActivation = true;
            ResetGame();
        }
    }

    private void ResetGame(){
        PlayerData.health = 10f;
        _playerController.playerData.highScore = _highScoreStateAtDeath;
        _playerController.killCounter = 0f;
        PlayerData.boostCharge = 10f;
        _timeManager.gamePaused = false;
        this.enabled = false;
    }

    private void OnEnable(){
        _playerController = FindObjectOfType<PlayerController>();
        _timeManager = FindObjectOfType<TimeManager>();
        
        _highScoreStateAtDeath = _playerController.playerData.highScore;
    }
}