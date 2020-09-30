using UnityEngine;
using static UnityEngine.Cursor;
using Debug = System.Diagnostics.Debug;

[RequireComponent(typeof(Transform))]
[DefaultExecutionOrder(-1002)]
public class GameManager : MonoBehaviour {
    public static Camera PlayerCamera { get; private set; }

    private static bool LockCursor {
        set => lockState = value ? CursorLockMode.Locked : CursorLockMode.None;
    }

    public static Vector3 CameraBounds { get; private set; }


    private void Awake(){
        PlayerCamera = FindObjectOfType<Camera>();
        Debug.Assert(PlayerCamera != null, nameof(PlayerCamera) + " != null");
        float width = PlayerCamera.scaledPixelWidth;
        float height = PlayerCamera.scaledPixelHeight;
        // Screen.SetResolution(960, 720, false, 60);
        CameraBounds = PlayerCamera.ScreenToWorldPoint(new Vector3(width, height,
            0f));
    }

    private void OnEnable(){
        LockCursor = false;
    }

    private void OnDisable(){
        LockCursor = false;
    }
}