using System.Collections.Generic;
using UnityEngine;

public class SpaceJunkManager : MonoBehaviour {
    private readonly int _numberOfSpaceJunk = 10;
    private readonly string _spaceJunkPath = "SpaceJunk";
    private List<GameObject> _spaceJunkList;
    private float _spawnTimer = 2f;

    private void Awake(){
        _spaceJunkList = new List<GameObject>(_numberOfSpaceJunk);
        for (int i = 0; i < _numberOfSpaceJunk; i++) {
            _spaceJunkList.Add(Instantiate(Resources.Load(_spaceJunkPath, typeof(GameObject))) as GameObject);
            _spaceJunkList[i].SetActive(false);
        }
    }


    private void FixedUpdate(){
        _spawnTimer -= Time.fixedDeltaTime;
        if (_spawnTimer <= 0f)
            if (_spaceJunkList.Count > 0)
                for (int i = 0; i < _spaceJunkList.Count - 1; i++) {
                    if (_spaceJunkList[i].activeSelf) continue;
                    _spaceJunkList[i].gameObject.SetActive(true);
                    _spawnTimer = 2;
                    break;
                 
                }
    }
}