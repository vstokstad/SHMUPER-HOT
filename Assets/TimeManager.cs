using System.Collections;
using UnityEngine;

public class TimeManager : MonoBehaviour {
    private const float _slowDownFactor = 0.0f;
    private float _fixedDeltaTime;

    private IEnumerator _freezeTime;

    private void Start(){
        _freezeTime = FreezeTime();
        _fixedDeltaTime = Time.fixedUnscaledDeltaTime;
        StartCoroutine(_freezeTime);
    }


    private IEnumerator FreezeTime(){
        while (!Input.anyKey) {
            Time.timeScale = _slowDownFactor;
            Time.fixedDeltaTime = Time.timeScale * _fixedDeltaTime;
            AudioListener.pause = true;
            yield return new WaitUntil(() => Input.anyKeyDown);
        }

        while (Input.anyKey) {
            Time.timeScale = 1f;
            Time.fixedDeltaTime = Time.timeScale * _fixedDeltaTime;
            AudioListener.pause = false;
            yield return new WaitUntil(() => Input.anyKey == false);
        }

        yield return FreezeTime();
    }
}