using UnityEngine;
using UnityEngine.SceneManagement;

public class GameOverScript : MonoBehaviour {
    private PlayerInput playerInput;
    private TimeManager timeManager;

    private void Update(){
        if (Input.GetKeyDown(KeyCode.Return)) {
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex, LoadSceneMode.Single);
            enabled = false;
        }
    }

    private void OnEnable(){
        timeManager = FindObjectOfType<TimeManager>();
        timeManager.timeState = TimeState.Stopped;
        playerInput = FindObjectOfType<PlayerInput>();
        playerInput.enabled = false;
    }
}