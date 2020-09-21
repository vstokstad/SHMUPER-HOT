
using static UnityEngine.Cursor;
using UnityEngine;

[RequireComponent(typeof(Transform))]
[DefaultExecutionOrder(-1000)]
public class GameManager : MonoBehaviour {
    public static Camera PlayerCamera { get; private set; }
    public static Transform PlayerCameraTransform { get; private set; }
    public static bool LockCursor {
        set { lockState = value ? CursorLockMode.Locked : CursorLockMode.None; }
    }
    public static Vector3 CameraBounds { get; private set; }


    private void Awake(){
        PlayerCamera = Camera.main;
        PlayerCameraTransform = PlayerCamera.transform;
        CameraBounds = PlayerCamera.ScreenToWorldPoint(new Vector3(Screen.width, Screen.height,
            0f));
    }

    private void OnEnable(){
        LockCursor = true;
    }

    private void OnDisable(){
        LockCursor = false;
    }
}